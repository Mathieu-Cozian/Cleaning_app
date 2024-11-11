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
  search(event) {
    const searchTerm = event.target.value.trim();
    const url = new URL(window.location.href);

    // Set search parameter in URL
    url.searchParams.set("search", searchTerm);

    // Retain sorting and status filters if present
    const currentStatus = url.searchParams.get("status");
    const sortColumn = url.searchParams.get("sort");
    const sortDirection = url.searchParams.get("direction");

    if (currentStatus) url.searchParams.set("status", currentStatus);
    if (sortColumn) url.searchParams.set("sort", sortColumn);
    if (sortDirection) url.searchParams.set("direction", sortDirection);

    // Fetch updated content and replace only the table content
    fetch(url.toString(), {
      headers: { "Accept": "text/vnd.turbo-stream.html" }
    })
        .then(response => response.text())
        .then(html => {
          const frame = document.getElementById("cleaners_table");
          frame.innerHTML = html; // Replace the content in the frame with new HTML
        })
        .catch(error => console.error("Error fetching search results:", error));
  }
}

