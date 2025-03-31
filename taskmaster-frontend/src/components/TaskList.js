import React, { useEffect, useState } from 'react';
import { getAllTasks, createTask, updateTask, deleteTask } from '../api';

const TaskList = () => {
  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState('');

  useEffect(() => {
    loadTasks();
  }, []);

  const loadTasks = async () => {
    const data = await getAllTasks();
    setTasks(data);
  };

  const handleAddTask = async () => {
    if (!title) return;
    const newTask = await createTask({ title, completed: false });
    setTasks([...tasks, newTask]);
    setTitle('');
  };

  const handleToggleTask = async (task) => {
    const updatedTask = await updateTask(task.id, { ...task, completed: !task.completed });
    setTasks(tasks.map(t => t.id === task.id ? updatedTask : t));
  };

  const handleDeleteTask = async (id) => {
    await deleteTask(id);
    setTasks(tasks.filter(task => task.id !== id));
  };

  return (
    <div>
      <h2>Task List</h2>
      <input value={title} onChange={(e) => setTitle(e.target.value)} placeholder="New task" />
      <button onClick={handleAddTask}>Add</button>
      <ul>
        {tasks.map(task => (
          <li key={task.id}>
            <span
              onClick={() => handleToggleTask(task)}
              style={{ textDecoration: task.completed ? 'line-through' : 'none', cursor: 'pointer' }}
            >
              {task.title}
            </span>
            <button onClick={() => handleDeleteTask(task.id)}>Delete</button>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default TaskList;
