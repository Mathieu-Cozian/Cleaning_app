// app/javascript/controllers/datatable_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["table"];

  connect() {
    if (!$.fn.dataTable.isDataTable(this.tableTarget)) {
      this.dataTable = $(this.tableTarget).DataTable(this.dataTableOptions);
      $(this.tableTarget).on('init.dt', this.init.bind(this));
    }
  }

  disconnect() {
    if ($.fn.dataTable.isDataTable(this.tableTarget)) {
      this.dataTable.destroy();
    }
  }

  filterByStatus(event) {
  Event.preventDefault();
    const status = event.target.getAttribute("data-status");
    this.dataTable.ajax.url(this.getDataUrl(status)).load();
  }

  getDataUrl(status) {
    const url = new URL(this.data.get("source"));
    if (status) {
      url.searchParams.set("status", status);
    } else {
      url.searchParams.delete("status");
    }
    return url.toString();
  }
  get dataTableOptions() {
    return {
      processing: true,
      serverSide: true,
      ajax: {
        url: this.data.get("source"), // URL for JSON data source
      },
      columns: [
        { data: "name" },
        { data: "email" },
        { data: "status" }
      ],
    };
  }
}