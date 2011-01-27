def time_block 
  start_time = Time.now 
  yield 
  return Time.now - start_time 
end 

def repeat_every(seconds) 
  while true do 
    sleep( seconds - time_block { yield } ) # again ignoring time > seconds 
  end 
end 
