class OpenAiService
  attr_reader :post, :client, :content

  def initialize(post)
    @post = post
    @content = post.html_source
    @client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_ACCESS_TOKEN"))
  end

  def call
    begin
      extraction_fields = ["title", "location", "contract_type", "published_on", "description", "experience_years", "company_name", "programming_language_stack"]

      scrape_attempt = '{
        "title": "title",
        "location": "location",
        "contract_type": "contract_type",
        "published_on": "YYYY-MM-DD",
        "description": "description",
        "experience_years": "experience_years",
        "company_name": "give the publisher company_name",
        "programming_language_stack": ["programming_language_stack_1","programming_language_stack_2","..."]
      }'

      prompt_parser = "Using only the information provided in the following raw text, extract the fields #{extraction_fields.join(',')}.
      If a specific field is not found in the text, mark its value as 'Not Available'.
      Do not make assumptions or add information not present in the text. Format the output as a JSON:
      Raw text: #{scrape_attempt}"

      prompt = content + prompt_parser

      response = client.chat(
        parameters: {
          model: "gpt-3.5-turbo",
            messages: [{ role: "user", content: prompt}],
            temperature: 0.7,
          })
      response.dig("choices", 0, "message", "content")
    rescue => e
      p e
      post.update(scrap_status: 'failed')
      nil
    end
  end
end
