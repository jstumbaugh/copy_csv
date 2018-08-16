require "copy_csv/version"

module CopyCsv
  extend ActiveSupport::Concern

  module ClassMethods
    # Performs a database query to copy results as CSV to an IO object.
    #
    # CSV is created directly in PostgreSQL with less overhead then written to
    # the provided IO object.
    #
    # Example
    #
    #     File.open("unsubscribed_users.csv", "w") do |file|
    #       User.where(unsubscribed: false).copy_csv(file)
    #     end
    #
    # Returns nil
    def copy_csv(io, relation: all)
      query = <<-SQL
        COPY (#{ relation.to_sql }) TO STDOUT WITH DELIMITER ',' CSV HEADER ENCODING 'UTF-8' QUOTE '"'
      SQL

      raw = connection.raw_connection
      raw.copy_data(query) do
        while (row = raw.get_copy_data)
          io.puts row
        end
      end

      nil
    end

    # Opens the file provided and writes the relation to it as a CSV.
    #
    # Example
    #
    #     User.where(unsubscribed: false).write_to_csv("unsubscribed_users.csv")
    #
    # Returns nil
    def write_to_csv(file_name, mode = "w")
      File.open(file_name, mode) do |file|
        all.copy_csv(file)
      end
    end
  end
end
