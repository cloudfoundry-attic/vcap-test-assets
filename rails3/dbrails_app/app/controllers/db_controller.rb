class DbController < ApplicationController
  STATUS = ['new', 'approved', 'invited', 'registered', 'prospect']

  # /db/init - initialize the database by deleting all spooge records, and recreating a random
  # set of records. by using srand with a fixed seed, random sequences are uniform
  def init
    count = 1000
    resp = { :record_count => count, :status => {}}
    sh = Hash.new
    STATUS.each do |item|
      sh[item] = 0
    end
    resp[:status] = sh
    resp[:records] = []
    srand 1234
    Spooge.delete_all()
    count.times do
      s = Spooge.new()
      n = generate_random_name
      s.name = n
      s.email = "#{n}@gmail.com"
      s.touch_date = DateTime.now
      s.status = STATUS[rand(STATUS.length)]
      s.save
      resp[:status][s.status] = resp[:status][s.status] + 1
      resp[:records] << s
    end

    r = {:record_count => 1000, :operation => 'success'}
    render :json => r
  end

  # /db/query - perform a query of all records whose status matches the randomly
  # selected status
  def query
    resp = {:records => []}
    status_key = STATUS[rand(STATUS.length)]
    ss = Spooge.find(:all, :conditions => {:status => "#{status_key}"})
    resp[:record_count] = ss.length
    ss.each do |s|
      resp[:records] << s
    end
    r = {:record_count => ss.length, :operation => 'success'}
    render :json => r
  end

  # /db/update - update the touch_date for the item whose name matches the randomly selected name
  def update
    status_key = STATUS[rand(STATUS.length)]

    # :limit doesn't seem to work?
    n = Spooge.update_all("touch_date = '#{DateTime.now}'", "status = '#{status_key}'", :limit => 5 )
    resp = {:updated => n, :status_key => status_key, :operation => 'success'}
    render :json => resp
  end

  # /db/create - create a new, random user
  def create
    s = Spooge.new()
    n = generate_random_name
    s.name = n
    s.email = "#{n}@gmail.com"
    s.touch_date = DateTime.now
    s.status = STATUS[rand(STATUS.length)]
    create_status = s.save

    resp = {:create_status => create_status, :record => s, :operation => 'success'}
    render :json => resp
  end


  # data generation
  def generate_random_name(size = 8)
    charset = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z}
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

end
