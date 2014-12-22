require 'yaml'

module NoBrainer::Tree::TreeMacros

  def setup_tree(tree)
    create_tree(YAML.load(tree))
  end

  def node(name)
    @nodes[name]
  end

  def node!(name)
    node(name).reload
  end

  def print_tree(node, inspect = false, depth = 0)
    print '  ' * depth
    print '- ' unless depth == 0
    print node.name
    print " (#{node.inspect})" if inspect
    print ':' if node.children.any?
    print "\n"
    node.children.each { |c| print_tree(c, inspect, depth + 1) }
  end

  private

  def create_tree(parent=nil, object)
    case object
    when String then return create_node(parent, object)
    when Array then object.each { |tree| create_tree(parent, tree) }
    when Hash then
      name, children = object.first
      node = create_node(parent, name)
      children.each { |child| create_tree(node, child) }
      return node
    end
  end

  def create_node(parent=nil, name)
    @nodes ||= HashWithIndifferentAccess.new
    @nodes[name] = subject.create(parent: parent, :name => name)
  end

  # def create_node(parent=nil, name)
  #   @nodes ||= HashWithIndifferentAccess.new
  #   @nodes[name] = Route.create(parent: parent, :name => name)
  # end
end

RSpec.configure do |config|
  config.include NoBrainer::Tree::TreeMacros
end
