class OpenAiJob < ApplicationJob
  queue_as :default

  def perform(post_id, user)
    post = Post.find(post_id)
    return unless post

    post.update!(scrap_status: 10)

    response = OpenAiService.new(post).call
    return unless response

    post.update(scrap_status: 'successful')
    parsed_response = JSON.parse(response)&.symbolize_keys
    return unless parsed_response
    puts "✅✅✅✅✅✅✅✅✅✅"
    p parsed_response
    puts "✅✅✅✅✅✅✅✅✅✅"

    company = Company.find_or_create_by(name: parsed_response[:company_name])

    techno = parsed_response[:programming_language_stack]
    if techno
      techno_downcase = techno.map(&:downcase)
      techno_downcase.each do |tech|
        stack = Stack.find_or_create_by(name: tech)
        PostStack.create(post: post, stack: stack)
      end
    end

    parsed_response.delete(:company_name) if parsed_response[:company_name]
    parsed_response.delete(:programming_language_stack) if parsed_response[:programming_language_stack]

    post.update(parsed_response)
    post.company = company if company

    TablepostChannel.broadcast_to(
      user,
      post
    )


    # Broadcast to the posts index
  end
end
