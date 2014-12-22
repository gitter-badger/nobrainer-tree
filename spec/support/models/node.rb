class Node
  include NoBrainer::Document
  include NoBrainer::Tree
  include NoBrainer::Tree::Traversal

  field :name
end

class SubclassedNode < Node
end

# Adding ordering on subclasses currently doesn't work as expected.
#
# class OrderedNode < Node
#   include NoBrainer::Tree::Ordering
# end
class OrderedNode
  include NoBrainer::Document
  include NoBrainer::Tree
  include NoBrainer::Tree::Traversal
  include NoBrainer::Tree::Ordering

  field :name
end

NoBrainer.sync_indexes

# class NodeWithEmbeddedDocument < Node
#   embeds_one :embedded_document, :cascade_callbacks => true
# end
#
# class EmbeddedDocument
#   include Mongoid::Document
# end
