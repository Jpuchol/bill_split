def build_evaluation_score_items
  raw_sql = "INSERT INTO your_table ('user_id', 'something_else') VALUES "
  insert_values = "('%s', '%s'),"
  self.job.active_employees.each do |employee|
    raw_sql += insert_values % employee.id, "something else"
  end
  ActiveRecord::Base.connection.execute raw_sql
end

def build_evaluation_score_items
  inserts = []
  time = Time.now.to_s(:db)
  self.job.active_employees.each do |employee|
    inserts.push "(#{self.id}, #{employee.id}, '#{time}')"
  end
  sql = "INSERT INTO scores (evaluation_id, user_id, created_at) VALUES #{inserts.join(", ")}"
  ActiveRecord::Base.connection.execute(sql) 
end

def build_evaluation_score_items
  new_scores = job.active_employees.map do |employee|
    scores.build(:user_id => employee.id)
  end
  Score.import new_scores
end

sql1 = "INSERT INTO parents (`name`) VALUES #{parent_name.join(", ")} RETURNING id"
   h_ids = ActiveRecord::Base.connection.execute sql1 #This returns a PGresult[1]
   ids = h_ids.map {|h| h['id']} #Now you have an array of ids

user_sql = "INSERT into users (id,username,password) VALUES\n"
check_sql = "INSERT into check_attributes (user_id,foo,bar) VALUES\n"
random_data_pool = [('0'..'9'),('A'..'Z'),('a'..'z')].collect(&:to_a).flatten
max_loop = 10

1.upto(max_loop) do |i|
 seperator = (i == max_loop) ? ';' : ",\n"
 username = (1..5).map{ random_data_pool[Kernel.rand(random_data_pool.size)] }.join
 password = (1..5).map{ random_data_pool[Kernel.rand(random_data_pool.size)] }.join
 user_sql += "(#{i},'#{username}','#{password}')" + seperator
 check_sql +="(#{i},true,'potato')" + seperator
end


ActiveRecord::Base.connection.execute(user_sql)
ActiveRecord::Base.connection.execute(check_sql)
