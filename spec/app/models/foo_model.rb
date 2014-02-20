class FooModel
  include MyMongoid::Document
  field :number
  def number=(n)
    self.attributes["number"] = n + 1
  end
end