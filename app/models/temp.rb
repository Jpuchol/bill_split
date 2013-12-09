class Temp < ActiveRecord::Base


  def self.clean_table
    sql="TRUNCATE TABLE temps"
    ActiveRecords:Base.connection.execute sql
  end

  def self.insert(userid, billid, amount)
    sql='INSERT INTO "temps" ("user_id,"bill_id","amount") VALUES (#{userid},#{billid},#{amount})'
    ActiveRecords::Base.connection.execute sql
  end

  def self.getusersum
    sql='SELECT SUM("temps"."amount") FROM temps GROUP BY user_id'
    ActiveRecords::Base.connection.execute sql
  end
end
