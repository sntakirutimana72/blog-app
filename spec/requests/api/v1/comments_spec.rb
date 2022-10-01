require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do

  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do

    parameter name: 'user_id', in: :path, type: :integer, description: 'Author Id'
    parameter name: 'post_id', in: :path, type: :integer, description: 'Post Id'

    get('list comments') do
      produces 'application/json'

      response(200, '') do
        schema '$ref' => '#/components/schemas/comment_get'
        run_test!
      end

      response(404, '') { run_test! }
    end
  end

  path '/api/v1/posts/{post_id}/comments' do
    parameter name: 'post_id', in: :path, type: :integer, description: 'Post Id'

    post('create comment') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :comment, in: :body, schema: { '$ref' => '#/components/schemas/comment' }
      parameter name: :Authentication, in: :header, required: true, type: :string

      response(201, 'Created successfully!') do
        schema '$ref' => '#/components/schemas/comment_failed'

        run_test!
      end

      response(401, 'Unauthorized') { run_test! }

      response(:unprocessable_entity, 'Error') do
        schema '$ref' => '#/components/schemas/comment_failed'

        run_test!
      end
    end
  end
end
