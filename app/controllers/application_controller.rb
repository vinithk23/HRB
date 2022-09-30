class ApplicationController < ActionController::Base

    def default_url_options
        {
          host: ActionMailer::Base.default_url_options[:host],
          port: ActionMailer::Base.default_url_options[:port],
        }
      end
      
end
