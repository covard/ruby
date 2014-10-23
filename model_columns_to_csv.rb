require 'smarter_csv'

module ModelColumnsToCsv
  def self.run(env)
    columns = []
    connect_db env
    ActiveRecord::Base.connection.tables.map do |model|
      puts model.classify.constantize.column_names
      exit
      # todo: remove columns: (id, updated_at, created_at, updated_by, created_by) and any other column that is not needed by the client
      # todo: write these out to csv file (in append mode or rather put them all into one array and then write them out as header)
    end
    disconnect_db
  end
end

ModelColumnsToCsv.run ARGV[0]
