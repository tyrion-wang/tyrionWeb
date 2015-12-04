class User < ActiveRecord::Base

  # 数字和字母6~16位
  def self.test_simple_password(pass)
    test = /^(?=.*\d)(?=.*[a-zA-Z]).{6,16}$/ =~ pass
    test == 0
  end

  # 性别：0保密，1男，2女
  def self.test_gender(gender)
    if gender.to_i>2 || gender.to_i<0
      return false
    end
    return true
  end

  # 年龄0-99
  def self.test_age(age)
    if age.to_i>100 || age.to_i<0
      return false
    end
    return true
  end

  def self.authenticate(email_or_cellphone, password)

    result = User.where('email = ? OR cellphone = ?',email_or_cellphone.downcase, email_or_cellphone.downcase)

    if result.size > 0
      user = result.first
      if user.password == password
        return user
      end
    end

    return nil
  end

  def self.find_account(email, cellphone)
    if email
      user = User.find_by_email email
    else
      user = User.find_by_cellphone cellphone
    end

    if user.blank?
      return false
    end
    return true
  end

  def private_info
    info = self.slice :id, :email, :cellphone, :name, :gender, :age, :brief, :portrait_img
    info
  end
end
