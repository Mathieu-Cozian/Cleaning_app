// app/javascript/controllers/cleaners_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { sortColumn: String, sortDirection: String }

  connect() {
    this.sortDirectionValue = this.sortDirectionValue || "asc";
  }

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
    let direction = this.sortDirectionValue;
    if (this.sortColumnValue === column) {
      direction = direction === "asc" ? "desc" : "asc";
    } else {
      direction = "asc";
    }
    console.log("Initial direction is:", this.sortDirectionValue);
    console.log("Direction after algo is:", direction);
    const url = new URL(window.location.href);
    const currentStatus = url.searchParams.get("status");
    url.searchParams.set("sort", column);
    url.searchParams.set("direction", direction);
    if (currentStatus) {
      url.searchParams.set("status", currentStatus); // Retain the status filter
    }
    Turbo.visit(url.toString(), { action: "replace", frame: "cleaners_table" });
    this.sortColumnValue = column;
    this.sortDirectionValue = direction;
  }
}