class OpenAiJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    return unless post

    post.scrap.update(scrap_status: 10)

    response = OpenAiService.new(post).call
    return unless response

    post.scrap.update(scrap_status: 30)
    parsed_response = JSON.parse(response)

    company = Company.find_or_create_by(name: parsed_response[:company_name])

    techno = parsed_response[:programming_language_stack]
    techno_downcase = techno.map do |tech|
      tech.downcase
    end

    techno_downcase.each do |tech|
      stack = Stack.find_or_create_by(name: tech)
      PostStack.create(post: post, stack: stack)
    end

    parsed_response.delete(:company_name)
    parsed_response.delete(:programming_language_stack)

    post.update(parsed_response)
    post.company = company

    if post.save
      render_ok
    else
      render_error
    end

    # Broadcast to the posts index
  end

  private

  def render_error
    render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
  end

  def render_ok
    render json: { message: "created" }, status: '201'
  end
end
