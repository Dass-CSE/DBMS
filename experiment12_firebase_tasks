// app.js (ES module)
import { initializeApp } from "https://www.gstatic.com/firebasejs/9.22.2/firebase-app.js";
import {
  getDatabase, ref, push, set, onChildAdded, onChildChanged, onChildRemoved,
  update, remove, query, orderByChild, get
} from "https://www.gstatic.com/firebasejs/9.22.2/firebase-database.js";

/*
  1) Replace firebaseConfig with your project info from Firebase console.
  2) Make sure Realtime Database is created (not Firestore).
*/
const firebaseConfig = {
  apiKey: "YOUR_API_KEY",
  authDomain: "YOUR_PROJECT.firebaseapp.com",
  databaseURL: "https://YOUR_PROJECT.firebaseio.com",
  projectId: "YOUR_PROJECT",
  storageBucket: "YOUR_PROJECT.appspot.com",
  messagingSenderId: "SENDER_ID",
  appId: "APP_ID"
};

const app = initializeApp(firebaseConfig);
const db = getDatabase(app);
const tasksRef = ref(db, "tasks");

// UI elements
const taskTitle = document.getElementById("taskTitle");
const taskAssignee = document.getElementById("taskAssignee");
const taskPriority = document.getElementById("taskPriority");
const addTaskBtn = document.getElementById("addTaskBtn");
const tasksList = document.getElementById("tasksList");
const filterStatus = document.getElementById("filterStatus");
const searchInput = document.getElementById("searchInput");

// Add a new task
addTaskBtn.addEventListener("click", async () => {
  const title = taskTitle.value.trim();
  if (!title) return alert("Enter a task title");
  const newTask = {
    title,
    assignee: taskAssignee.value.trim() || "Unassigned",
    priority: taskPriority.value,
    status: "todo",       // todo | inprogress | done
    createdAt: Date.now()
  };
  const taskRef = push(tasksRef);
  await set(taskRef, newTask);
  taskTitle.value = "";
  taskAssignee.value = "";
});

// Helper to render a task card
function renderTask(id, data) {
  // if card exists update, else create
  let card = document.getElementById(id);
  const matchesFilter = () => {
    const f = filterStatus.value;
    if (f === "all") return true;
    return data.status === f;
  };
  const matchesSearch = () => {
    const s = (searchInput.value || "").toLowerCase();
    if (!s) return true;
    return data.title.toLowerCase().includes(s) || data.assignee.toLowerCase().includes(s);
  };
  if (!matchesFilter() || !matchesSearch()) {
    if (card) card.remove();
    return;
  }

  const priorityClass = data.priority === "low" ? "priority-low" : data.priority === "medium" ? "priority-medium" : "priority-high";

  if (!card) {
    card = document.createElement("div");
    card.className = "card";
    card.id = id;
    card.innerHTML = `
      <div class="left">
        <div style="display:flex;gap:8px;align-items:center;">
          <strong class="title"></strong>
          <span class="badge ${priorityClass}"></span>
        </div>
        <div class="meta small"></div>
        <div class="desc small"></div>
      </div>
      <div class="actions">
        <button class="statusBtn"></button>
        <button class="editBtn">Edit</button>
        <button class="delBtn">Delete</button>
      </div>
    `;
    tasksList.prepend(card);

    // button events
    card.querySelector(".delBtn").addEventListener("click", () => {
      if (confirm("Delete this task?")) remove(ref(db, `tasks/${id}`));
    });
    card.querySelector(".editBtn").addEventListener("click", async () => {
      const newTitle = prompt("Edit title", data.title);
      if (newTitle === null) return;
      const newAssignee = prompt("Edit assignee", data.assignee);
      if (newAssignee === null) return;
      await update(ref(db, `tasks/${id}`), { title: newTitle, assignee: newAssignee });
    });
    card.querySelector(".statusBtn").addEventListener("click", () => {
      const next = data.status === "todo" ? "inprogress" : data.status === "inprogress" ? "done" : "todo";
      update(ref(db, `tasks/${id}`), { status: next });
    });
  }

  // update contents
  card.querySelector(".title").textContent = data.title;
  card.querySelector(".badge").textContent = data.priority.toUpperCase();
  card.querySelector(".badge").className = `badge ${priorityClass}`;
  const created = new Date(data.createdAt).toLocaleString();
  card.querySelector(".meta").textContent = `Assignee: ${data.assignee} • Created: ${created}`;
  card.querySelector(".desc").textContent = `Status: ${data.status}`;
  const statusBtn = card.querySelector(".statusBtn");
  statusBtn.textContent = data.status === "todo" ? "Start" : data.status === "inprogress" ? "Complete" : "Reopen";
}

// Listen for new tasks
onChildAdded(tasksRef, snapshot => {
  renderTask(snapshot.key, snapshot.val());
});

// Listen for updates
onChildChanged(tasksRef, snapshot => {
  renderTask(snapshot.key, snapshot.val());
});

// Listen for deletes
onChildRemoved(tasksRef, snapshot => {
  const el = document.getElementById(snapshot.key);
  if (el) el.remove();
});

// Filters & search re-render: simple approach -> fetch current list and reapply
filterStatus.addEventListener("change", () => {
  // re-query existing tasks (lightweight)
  get(tasksRef).then(snap => {
    tasksList.innerHTML = "";
    if (!snap.exists()) return;
    const obj = snap.val();
    Object.entries(obj).sort((a,b)=> b[1].createdAt - a[1].createdAt).forEach(([id, data]) => renderTask(id, data));
  });
});
searchInput.addEventListener("input", () => filterStatus.dispatchEvent(new Event('change')));

// Initial load
get(query(tasksRef, orderByChild('createdAt'))).then(snap => {
  tasksList.innerHTML = "";
  if (!snap.exists()) return;
  const obj = snap.val();
  Object.entries(obj).sort((a,b)=> b[1].createdAt - a[1].createdAt).forEach(([id, data]) => renderTask(id, data));
});
