class PaperclipI18nGenerator < Rails::Generators::Base
  include(Rails::Generators::Migration)
  source_root(File.expand_path('../templates', __FILE__))

  # taken from: http://www.themodestrubyist.com/2010/03/16/rails-3-plugins---part-3---rake-tasks-generators-initializers-oh-my/
  def self.next_migration_number(dirname)
    if ::ActiveRecord::Base.timestamped_migrations
      ::Time.now.utc.strftime('%Y%m%d%H%M%S')
    else
      '%.3d' % (current_migration_number(dirname) + 1)
    end
  end

  desc "Creates an asset model & migration, prepares an assets controller"
  def create_paperclip_i18n_migration
    migration_template('migration.rb', 'db/migrate/paperclip_i18n_tables.rb')
    copy_file('assets_controller.rb', 'app/controllers/assets_controller.rb')
    copy_file('asset.rb', 'app/models/asset.rb')
  end
end
