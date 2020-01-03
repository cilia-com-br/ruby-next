require_relative '../test_unit_to_mspec'

using TestUnitToMspec

# These tests are not copied from ruby/ruby
describe "custom tests" do
  # multiple clauses with arrays
  assert_block do
    case [0, 1, 2]
    in [0, 2, *a]
      false
    in [0, *a]
      a == [1, 2]
    end
  end

  #  multiple clauses with hash
  assert_block do
    case {a: 0, b: 1}
      in a: 1, **b
        false
      in a:, **b
        a == 0 && b == {b: 1}
      end
  end

  # in with hash
  assert_block do
    {a: [0, 1, 2]} in {a:}
    a == [0, 1, 2]
  end

  # in with hash and array rest
  assert_block do
    {a: [0, 1, 2]} in {a: [0, *r]}
    r == [1, 2]
  end

  # non-matching in
  assert_block do
    if 0 in 1 | 2
      flunk
    else
      true
    end
  end

  # non-matching with match var
  assert_block do
    {a:0, b: 1} in {c:, **nil}
    c.nil?
  end
end