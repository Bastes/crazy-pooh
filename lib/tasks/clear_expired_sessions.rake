desc "Clear expired sessions"
task :clear_expired_sessions => :environment do
  ActiveRecord::Base.connection.execute("DELETE FROM sessions WHERE updated_at < now() - interval '1 day';")
end


