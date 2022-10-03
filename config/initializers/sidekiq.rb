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

  config.redis = { url: 'redis://redis-11627.c61.us-east-1-3.ec2.cloud.redislabs.com:11627', password: 6yedgGot7w0BkxdQTM1wxZYPtIwVbpdA, namespace: "#{Rails.env}" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis-11627.c61.us-east-1-3.ec2.cloud.redislabs.com:11627', password: 6yedgGot7w0BkxdQTM1wxZYPtIwVbpdA, namespace: "#{Rails.env}" }
end