shared_examples_for 'a hub with history' do

  it 'should maintain a list of events' do
    hub.history('test-event').should == []
    (1..3).each { |i| hub.publish 'test-event', index: i }
    history = hub.history('test-event')
    history.should be_a Array
    history.should have(3).entries
    history.map { |h| h['index'] }.should == [3, 2, 1]
  end

  it 'should let you control the number' do
    (1..3).each { |i| hub.publish 'test-event', index: i }
    result = hub.history('test-event', 1)
    result.should be_a Array
    result.should have(1).item
    result.first['index'].should == 3
  end

  it 'should give a sliding window' do
    (1..3).each { |i| hub.publish 'test-event', index: i }
    history = -> { hub.history 'test-event', 3 }
    expect do
      hub.publish 'test-event', index: 4
    end.to change(history, :call)
  end

  it 'should work correctly with top level lists' do
    hub.publish 'x', type: 'x'
    hub.publish 'x', type: 'x'
    hub.history('x').map { |r| r['type'] }.should == %w(x x)
  end

  it 'should work correctly with nested lists' do
    hub.publish 'x',   type: 'x'
    hub.publish 'x:y:z', type: 'x:y:z'
    hub.publish 'x:y',   type: 'x:y'
    hub.history('x:y:z').map { |r| r['type'] }.should == %w(x:y:z)
    hub.history('x:y').map { |r| r['type'] }.should == %w(x:y x:y:z)
    hub.history('x').map { |r| r['type'] }.should == %w(x:y x:y:z x)
  end

  it 'should return an empty array with any objects' do
    hub.history('blah').should == []
  end

  it "should return the correct data if it doesn't fill the limit" do
    (1..3).each { |i| hub.publish('other', index: i) }
    hub.history('other', 10).map { |i| i['index'] }.should == [3, 2, 1]
  end

  it "should return the full set if it fits the limit" do
    (1..10).each { |i| hub.publish('other', index: i) }
    hub.history('other', 10).map { |i| i['index'] }.should == (1..10).to_a.reverse
  end

  it "should return a cut down set if it's more than the limit" do
    (1..15).each { |i| hub.publish('other', index: i) }
    hub.history('other', 10).map { |i| i['index'] }.should == (6..15).to_a.reverse
  end

end