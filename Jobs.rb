class Jobs
  def organizeJobs(job, jobOrder)
    # Check if the job has a dependency.
    if job.include? ","
    # Split the job and ites dependency on the comma.
      jobs = job.split(',')
      # If the dependency is the same as the job then raise an error.
      if jobs[0] == jobs[1]
        raise "Jobs cannot depend on themselves"
      end
      # Try to find the dependency in the job list if it exists already
      # If it doesn't then add both at the end of the job list.
      if jobOrder.index(jobs[1]) == nil
        jobOrder += jobs[1]
        jobOrder += jobs[0]
      else
      # If the dependency is in the job list then add the other job ahead of it. 
        jobOrder.insert(jobOrder.index(jobs[1])+1, jobs[0])
        # If one of the job ids is found twice in the list then we have a circular dependency.
        if jobOrder.count(jobs[0]) > 1 or jobOrder.count(jobs[1]) > 1
          raise "Circular Dependency exception"
        end
      end
    else  
      # If the job only has the one id in it, add it to the end of it. 
      jobOrder += job
    end
    return jobOrder
  end
end