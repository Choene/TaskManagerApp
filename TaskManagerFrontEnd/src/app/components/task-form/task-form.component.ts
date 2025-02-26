import { Component, EventEmitter, Output } from '@angular/core';
import { TaskService } from '../../services/task.service';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Task } from '../../models/task.model';

@Component({
  selector: 'app-task-form',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './task-form.component.html',
  styleUrls: ['./task-form.component.css'],
})
export class TaskFormComponent {
  @Output() taskAdded = new EventEmitter<Task>();
  task: Task = { id: 0, title: '', description: '', dueDate: new Date().toISOString() };

  constructor(private taskService: TaskService) {}

  addTask(): void {
    if (!this.task.title) return;

    this.taskService.addTask(this.task).subscribe(() => {
      this.taskAdded.emit(this.task);
      this.task = { id: 0, title: '', description: '', dueDate: new Date().toISOString() };
    });
  }

  submitTask(): void {
    this.addTask();
  }
}
