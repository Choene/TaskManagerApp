import { Component, OnInit } from '@angular/core';
import { TaskService } from '../../services/task.service';
import { CommonModule } from '@angular/common';
import { TaskItemComponent } from '../task-item/task-item.component';
import { Task } from '../../models/task.model';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-task-list',
  standalone: true,
  imports: [CommonModule, TaskItemComponent, FormsModule],
  templateUrl: './task-list.component.html',
  styleUrls: ['./task-list.component.css'],
})
export class TaskListComponent implements OnInit {
  tasks: Task[] = [];

  constructor(private taskService: TaskService) {}

  ngOnInit(): void {
    this.loadTasks();
  }

  loadTasks(): void {
    this.taskService.getTasks().subscribe((tasks) => {
      this.tasks = tasks.map((task) => ({
        ...task,
        isEditing: false,
      }));
    });
  }

  addTask(newTask: Task): void {
    this.taskService.addTask(newTask).subscribe((task) => {
      this.tasks = [...this.tasks, { ...task, isEditing: false }];
    });
  }

  editTask(task: Task): void {
    task.isEditing = true;
  }

  saveTask(task: Task): void {
    this.taskService.updateTask(task).subscribe(() => {
      task.isEditing = false;
    });
  }

  cancelEdit(task: Task): void {
    task.isEditing = false;
    this.loadTasks();
  }

  deleteTask(id: number): void {
    this.taskService.deleteTask(id).subscribe(() => {
      this.tasks = this.tasks.filter((task) => task.id !== id);
    });
  }
}
