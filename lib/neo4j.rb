include Java

require 'enumerator'
require 'forwardable'
require 'neo4j/jars/neo4j-kernel-1.1.jar'
require 'neo4j/jars/geronimo-jta_1.1_spec-1.1.1.jar'
require 'neo4j/jars/lucene-core-2.9.2.jar'
require 'neo4j/jars/neo4j-index-1.1.jar'

require 'neo4j/to_java'
require 'neo4j/version'
require 'neo4j/equal'
require 'neo4j/index'
require 'neo4j/lucene_synchronizer'
require 'neo4j/relationship_traverser'
require 'neo4j/database'
require 'neo4j/node_traverser'
require 'neo4j/property'
require 'neo4j/transaction'
require 'neo4j/node_relationship'
require 'neo4j/relationship'
require 'neo4j/node'
require 'neo4j/config'
require 'neo4j/mapping/classmethods/property_class_methods'
require 'neo4j/mapping/classmethods/index_class_methods'
require 'neo4j/mapping/classmethods/relationship_class_methods'
require 'neo4j/mapping/decl_relationship_dsl'
require 'neo4j/mapping/has_n'
require 'neo4j/mapping/node_mixin'
require 'neo4j/node_mixin'

# rails
require 'rails/railtie'
require 'active_model'
require 'neo4j/rails/transaction_management'
require 'neo4j/rails/railtie'
require 'neo4j/rails/activemodel'
require 'neo4j/rails/value'


# hmm, looks like Enumerator have been moved in some ruby versions
Enumerator = Enumerable::Enumerator unless defined? Enumerator

module Neo4j

  class << self

    def start(this_db=nil)
      @db = this_db if this_db
      db
    end

    def db
      @db ||= Database.new
    end

    def shutdown(this_db = @db)
      this_db.shutdown if this_db
      @db = nil if this_db == @db
    end

    def ref_node(this_db = db)
      db.graph.reference_node
    end

    # Returns an Enumerable object for all nodes in the database
    def all_nodes(this_db = db)

      Enumerator.new(this_db, :each_node)
      #Enumerator.new(this_db, :each_node)
    end

  end
end
