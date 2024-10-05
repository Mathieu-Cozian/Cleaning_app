import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    console.log("SearchClientController is connected")
  }
  search() {
    const query = this.inputTarget.value

    // Add this log to check if the results target is recognized
    console.log(this.resultsTarget)

    if (query.length > 2) {
      fetch(`/clients/search?query=${query}`, { headers: { 'Accept': 'application/json' } })
          .then(response => {
            if (!response.ok) {
              throw new Error("Network response was not ok");
            }
            return response.json();  // Parse the JSON response
          })

          .then((data) => {
            this.updateResults(data)
          })
          .catch((error) => {
            console.error('Error:', error);
          });
    } else {
      this.resultsTarget.innerHTML = ""  // Clear results if input is too short
    }
  }

  updateResults(clients) {
    this.resultsTarget.innerHTML = ""

    clients.forEach((client) => {
      const clientItem = document.createElement('div')
      clientItem.innerHTML = `${client.first_name} ${client.last_name}`
      clientItem.classList.add('dropdown-item')

      clientItem.addEventListener('click', () => {
        document.getElementById('client-id').value = client.id
        this.inputTarget.value = `${client.first_name} ${client.last_name}`
        this.resultsTarget.innerHTML = "" // Clear the dropdown after selection
      })

      this.resultsTarget.appendChild(clientItem)
    })
  }
}