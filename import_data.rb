require './environment'
importer = DataImporter.new
# importer.clear_data
importer.import_stadiums
importer.import_distances(false)
importer.import_schedule
