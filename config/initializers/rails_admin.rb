RailsAdmin.config do |config|
  config.model 'Photo' do
    configure :thumbnail_url do
      pretty_value do
        object = bindings[:object]
        %{<a target="_blank" href=#{object.thumbnail_url}>#{object.file_key}</a >}.html_safe
      end
      read_only true # won't be editable in forms (alternatively, hide it in edit section)
    end

    configure :normal_url do
      pretty_value do
        object = bindings[:object]
        %{<a target="_blank" href=#{object.normal_url}>#{object.file_key}</a >}.html_safe
      end
      read_only true # won't be editable in forms (alternatively, hide it in edit section)
    end
  end

  config.model 'ProfilePhoto' do
    configure :thumbnail_url do
      pretty_value do
        object = bindings[:object]
        %{<a target="_blank" href=#{object.thumbnail_url}>#{object.file_key}</a >}.html_safe
      end
      read_only true # won't be editable in forms (alternatively, hide it in edit section)
    end

    configure :normal_url do
      pretty_value do
        object = bindings[:object]
        %{<a target="_blank" href=#{object.normal_url}>#{object.file_key}</a >}.html_safe
      end
      read_only true # won't be editable in forms (alternatively, hide it in edit section)
    end
  end

  config.model 'Video' do
    configure :thumbnail_url do
      pretty_value do
        object = bindings[:object]
        %{<a target="_blank" href=#{object.thumbnail_url}>#{object.file_key}</a >}.html_safe
      end
      read_only true # won't be editable in forms (alternatively, hide it in edit section)
    end

    configure :video_url do
      pretty_value do
        object = bindings[:object]
        %{<a target="_blank" href=#{object.video_url}>#{object.file_key}</a >}.html_safe
      end
      read_only true # won't be editable in forms (alternatively, hide it in edit section)
    end
  end

  config.model 'Audio' do
    configure :audio_url do
      pretty_value do
        object = bindings[:object]
        %{<a target="_blank" href=#{object.audio_url}>#{object.file_key}</a >}.html_safe
      end
      read_only true # won't be editable in forms (alternatively, hide it in edit section)
    end
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
