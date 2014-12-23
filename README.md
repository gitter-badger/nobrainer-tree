# nobrainer-tree ![Build Status](https://travis-ci.org/secondimpression/nobrainer-tree.svg?branch=nobrainer) [![Dependency Status](https://gemnasium.com/secondimpression/nobrainer-tree.png)](https://gemnasium.com/secondimpression/nobrainer-tree)

A tree structure for NoBrainer documents using the materialized path pattern

## Requirements

* nobrainer (~> 0.20.0)


## Install

To install nobrainer-tree, simply add it to your Gemfile:

    gem 'nobrainer-tree', :require => 'nobrainer/tree'

In order to get the latest development version of nobrainer-tree:

    gem 'nobrainer-tree', :git => 'git://github.com/secondimpression/nobrainer-tree'

You might want to add `:require => nil` option and explicitly `require 'nobrainer/tree'` where needed and finally run

    bundle install


## Usage

Read the API documentation at https://github.com/secondimpression/nobrainer-tree and take a look at the `NoBrainer::Tree` module

```ruby
class Node
  include NoBrainer::Document
  include NoBrainer::Tree
end
```


### Utility methods

There are several utility methods that help getting to other related documents in the tree:

```ruby
Node.root
Node.roots
Node.leaves

node.root
node.parent
node.children
node.ancestors
node.ancestors_and_self
node.descendants
node.descendants_and_self
node.siblings
node.siblings_and_self
node.leaves
```

In addition it's possible to check certain aspects of the document's position in the tree:

```ruby
node.root?
node.leaf?
node.depth
node.ancestor_of?(other)
node.descendant_of?(other)
node.sibling_of?(other)
```

See `NoBrainer::Tree` for more information on these methods.


### Ordering

`NoBrainer::Tree` doesn't order children by default. To enable ordering of tree nodes include the `NoBrainer::Tree::Ordering` module. This will add a `position` field to your document and provide additional utility methods:

```ruby
node.lower_siblings
node.higher_siblings
node.first_sibling_in_list
node.last_sibling_in_list

node.move_up
node.move_down
node.move_to_top
node.move_to_bottom
node.move_above(other)
node.move_below(other)

node.at_top?
node.at_bottom?
```

Example:

```ruby
class Node
  include NoBrainer::Document
  include NoBrainer::Tree
  include NoBrainer::Tree::Ordering
end
```

See `NoBrainer::Tree::Ordering` for more information on these methods.


### Traversal

It's possible to traverse the tree using different traversal methods using the `NoBrainer::Tree::Traversal` module.

Example:

```ruby
class Node
  include NoBrainer::Document
  include NoBrainer::Tree
  include NoBrainer::Tree::Traversal
end

node.traverse(:breadth_first) do |n|
  # Do something with Node n
end
```


### Destroying

`NoBrainer::Tree` does not handle destroying of nodes by default. However it provides several strategies that help you to deal with children of deleted documents. You can simply add them as `before_destroy` callbacks.

Available strategies are:

* `:nullify_children` -- Sets the children's parent_id to null
* `:move_children_to_parent` -- Moves the children to the current document's parent
* `:destroy_children` -- Destroys all children by calling their `#destroy` method (invokes callbacks)
* `:delete_descendants` -- Deletes all descendants using a database query (doesn't invoke callbacks)

Example:

```ruby
class Node
  include NoBrainer::Document
  include NoBrainer::Tree

  before_destroy :nullify_children
end
```


### Callbacks

There are two callbacks that are called before and after the rearranging process. This enables you to do additional computations after the documents position in the tree is updated. See `NoBrainer::Tree` for details.

Example:

```ruby
class Page
  include NoBrainer::Document
  include NoBrainer::Tree

  after_rearrange :rebuild_path

  field :slug
  field :path

  private

  def rebuild_path
    self.path = self.ancestors_and_self.collect(&:slug).join('/')
  end
end
```


### Validations

`NoBrainer::Tree` currently does not validate the document's children or parent associations by default. To explicitly enable validation for children and parent documents it's required to add a `validates_associated` validation.

Example:

```ruby
class Node
  include NoBrainer::Document
  include NoBrainer::Tree

  validates_associated :parent, :children
end
```


## Build Status

nobrainer-tree is on [Travis CI](http://travis-ci.org/secondimpression/nobrainer-tree) running the specs on Ruby Head, Ruby 1.9.3, Ruby 2.0 and Ruby 2.1


## Known issues

See [https://github.com/secondimpression/nobrainer-tree/issues](https://github.com/secondimpression/nobrainer-tree/issues)


## Repository

See [https://github.com/secondimpression/nobrainer-tree](https://github.com/secondimpression/nobrainer-tree) and feel free to fork it!


## Contributors

See a list of all contributors at [https://github.com/benedikt/mongoid-tree/contributors](https://github.com/benedikt/mongoid-tree/contributors) and [https://github.com/secondimpression/nobrainer-tree/contributors](https://github.com/secondimpression/nobrainer-tree/contributors). Thanks a lot everyone!


## Support

If you like nobrainer-tree and want to support the development, the original author would appreciate a small donation:

[![Pledgie](http://www.pledgie.com/campaigns/12137.png?skin_name=chrome)](http://www.pledgie.com/campaigns/12137)

[![Flattr](https://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=benediktdeicke&url=https://github.com/benedikt/mongoid-tree&title=mongoid-tree&language=&tags=github&category=software)


## Copyright

Copyright (c) 2010-2013 Benedikt Deicke. See LICENSE for details.
