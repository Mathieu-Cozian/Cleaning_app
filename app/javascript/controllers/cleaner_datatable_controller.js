import { Controller } from "@hotwired/stimulus"
import Datatable from "./datatable_controller";

// Connects to data-controller="cleaner-datatable"
export default class extends Controller {
  connect() {
  }

  get columns{
    return [
      { data: "name" },
      { data: "email" },
      { data: "status" }
    ]
  }
}
