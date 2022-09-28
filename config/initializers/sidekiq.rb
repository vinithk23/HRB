require 'sidekiq'
require 'sidekiq-scheduler'
require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Sidekiq.configure_server do |config|
  config.on(:startup) do
    Sidekiq::Scheduler.dynamic = true
    Sidekiq.schedule = YAML.load_file(File.expand_path('../../sidekiq_scheduler.yml', __FILE__))
    SidekiqScheduler::Scheduler.instance.reload_schedule!
  end
  config.redis = { url: 'redis://localhost:6379/0', namespace: "#{Rails.env}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0', namespace: "#{Rails.env}" }
end