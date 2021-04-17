# frozen_string_literal: true

module JsonSchemas
  def user_json_types
    {
        id: :integer,
        email: :string,
        first_name: :string,
        last_name: :string
    }
  end

  def user_json(user)
    {
        id: user.id,
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name
    }
  end

  def page_json_types
    {
      id: :integer,
      title: :string,
      description: :string,
      user_id: :integer
    }
  end

  def page_json(page)
    {
      id: page.id,
      title: page.title,
      description: page.description,
      user_id: page.user_id
    }
  end
end
