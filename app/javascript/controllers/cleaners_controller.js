// app/javascript/controllers/cleaners_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { sortColumn: String, sortDirection: String }


  // Action for filtering by status
  filterStatus(event) {
    event.preventDefault();
    const status = event.target.dataset.status;
    console.log("Selected status:", status); // Debug: Log selected status

    const url = new URL(window.location.href);
    url.searchParams.set("status", status);
    console.log("Updated URL:", url.toString()); // Debug: Log updated URL

    Turbo.visit(url.toString(), { action: "replace", frame: "cleaners_table" });
  }

  // Action for sorting columns
  sort(event) {
    event.preventDefault();
    const column = event.target.dataset.sortColumn;
    // Retrieve the persisted direction from localStorage, or default to "desc"
    let direction = localStorage.getItem("sortDirection") || "desc";
    // Toggle direction
    direction = (direction === "desc") ? "asc" : "desc";
    const url = new URL(window.location.href);
    const currentStatus = url.searchParams.get("status");
    url.searchParams.set("sort", column);
    url.searchParams.set("direction", direction);
    if (currentStatus) {
      url.searchParams.set("status", currentStatus);
    }

    // Use Turbo to update the page
    Turbo.visit(url.toString(), { action: "replace", frame: "cleaners_table" });
    // Persist the new direction in localStorage
    localStorage.setItem("sortDirection", direction);
  }
}