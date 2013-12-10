class Temp < ActiveRecord::Base
  belongs_to :bill
  belongs_to :user
  validates :bill_id, presence: true
  validates :user_id, presence: true


  def self.clean_table
    sql="TRUNCATE TABLE temps"
    ActiveRecords:Base.connection.execute sql
  end

  def self.insert(userid, billid, amount)
    sql='INSERT INTO "temps" ("user_id,"bill_id","amount") VALUES (#{userid},#{billid},#{amount})'
    ActiveRecords::Base.connection.execute sql
  end

  def self.getusersum
    sql='SELECT "temps"."user_id",SUM("temps"."amount") FROM temps GROUP BY user_id'
    ActiveRecords::Base.connection.execute sql
  end

  def self.sum_from_temp_by_user(user)
    sql="SELECT SUM(temps.amount) FROM temps WHERE GROUP"
  end

  def feed2
    Temp.get_uniq_userid(self)
  end

  def self.get_uniq_userid(user)
    user_ids = "SELECT user_id FROM temps GROUP BY user_id"
    where ("id IN (#{user_ids})")
  end

end
