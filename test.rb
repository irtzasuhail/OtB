require_relative "Jobs"
require "test/unit"
 
class TestJobs < Test::Unit::TestCase
  
  def testEmptyJobs
    assert_equal('',Jobs.new().organizeJobs('',''))
  end

  def testAddOneJob
  	assert_equal('a',Jobs.new().organizeJobs('','a'))
  end

  def testAddTwoJob
  	jobs = ''
  	jobs = Jobs.new().organizeJobs('','a')
  	assert_equal('ab',Jobs.new().organizeJobs('b',jobs))
  end

  def testAddDependency
  	assert_equal('ba',Jobs.new().organizeJobs('a,b',''))
  end

  def testAddTwoDependenies
  	jobs = ''
  	jobs = Jobs.new().organizeJobs('','a')
  	assert_equal('acb',Jobs.new().organizeJobs('b,c',jobs))
  end

  def testAddThreeDependenies
  	jobs = ''
  	jobs = Jobs.new().organizeJobs('','a')
  	jobs = Jobs.new().organizeJobs('b,c',jobs)
  	assert_equal('acbed',Jobs.new().organizeJobs('d,e',jobs))
  end

  def testAddThreeDependenies
  	jobs = ''
  	jobs = Jobs.new().organizeJobs('','a')
  	jobs = Jobs.new().organizeJobs('b,c',jobs)
  	assert_equal('acdb',Jobs.new().organizeJobs('d,c',jobs))
  end

  def testSelfDependency
  	exception = assert_raise(RuntimeError) {Jobs.new().organizeJobs('c,c','')}
  	assert_equal("Jobs cannot depend on themselves", exception.message) 
  end

  def testCircularDependency
	
	jobs = ''
  	jobs = Jobs.new().organizeJobs('b,c',jobs)
  	jobs = Jobs.new().organizeJobs('c,f',jobs)
  	exception = assert_raise(RuntimeError) {Jobs.new().organizeJobs('f,b',jobs)}
  	assert_equal("Circular Dependency exception", exception.message) 
  end

end