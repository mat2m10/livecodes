class Task
  attr_reader :title, :id, :description
  attr_accessor :done
  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end
  # CREATE UPDATE
  def save
    @id ? update : insert
  end

  # READ
  def self.find(id)
    DB.results_as_hash = true
    result = DB.execute("SELECT * FROM tasks WHERE id = ?", id.to_i).first
    result.nil? ? nil : build_task(result)
  end

  def self.all
    DB.results_as_hash = true
    result = DB.execute("SELECT * FROM tasks")
    result.nil? ? nil : result.map! {|hash| build_task(hash)}
  end

  # DESTROY
  def destroy
    DB.execute("DELETE FROM tasks WHERE id = ?", @id)
  end
  private
  def update
    DB.execute("UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?", @title, @description, @done ? 1:0, @id)
  end

  def insert
    DB.execute("INSERT INTO tasks (title, description, done) VALUES (?,?,?)", @title, @description, @done ? 1:0)
    @id = DB.last_insert_row_id
  end

  def self.build_task(result)
    Task.new(id: result['id'].to_i, title:result['title'], description: result['description'], done: result['done'] == 1)
  end
end
