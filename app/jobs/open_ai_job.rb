class OpenAiJob < ApplicationJob
  queue_as :default

  def perform(prompt_content)
    OpenAI.configure do |config|
      config.access_token = ENV.fetch("OPENAI_ACCESS_TOKEN")
    end

    extraction_fields = ["title", "location", "contract_type", "published_on", "description", "experience_years", "company_name", "programming_language_stack"]

    scrape_attempt = '{
      "title": "title",
      "location": "location",
      "contract_type": "contract_type",
      "published_on": "published_on",
      "description": "description",
      "experience_years": "experience_years",
      "company_name": "company_name",
      "programming_language_stack": "programming_language_stack"
    }'

    prompt_parser = "Using only the information provided in the following raw text, extract the fields #{extraction_fields.join(',')}.
    If a specific field is not found in the text, mark its value as 'Not Available'.
    Do not make assumptions or add information not present in the text. Format the output as a JSON:
    Raw text: #{scrape_attempt}"

    prompt = prompt_content + prompt_parser

    client = OpenAI::Client.new

    response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo",
            messages: [{ role: "user", content: prompt}],
            temperature: 0.7,
        })
    puts response.dig("choices", 0, "message", "content")
  end
end
