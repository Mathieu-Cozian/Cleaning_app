// app/javascript/controllers/cleaners_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  static values = { sortColumn: String, sortDirection: String }

  // Action for filtering by status
  filterStatus(event) {
    const status = event.target.value;
    const url = new URL(window.location.href);
    url.searchParams.set("status", status);

    // Update the URL directly to reflect the filter
    window.location.href = url.toString();
  }

  // Action for sorting columns
  sort(event) {
    event.preventDefault();

    const column = event.target.dataset.sortColumn;
    let direction = "asc";
    if (this.sortColumnValue === column && this.sortDirectionValue === "asc") {
      direction = "desc";
    }

    // Update the URL for sorting
    const url = new URL(window.location.href);
    url.searchParams.set("sort", column);
    url.searchParams.set("direction", direction);

    // Apply the sorting by changing the URL directly
    window.location.href = url.toString();
  }
}