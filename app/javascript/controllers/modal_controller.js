import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  open(event) {
    event.preventDefault();

    this.modalTarget.showModal();

    this.modalTarget.addEventListener('click', (e) =>  this.backdropClick(e));
  }

  close(event) {
    event.preventDefault();

    this.modalTarget.close();
  }
  backdropClick(event) {
    event.target === this.modalTarget && this.close(event);
  }

  addComment(event) {
    event.preventDefault();

    // Récupérer les données du formulaire
    const formData = new FormData(event.target);
    const commentText = formData.get('comment');

    // Faites quelque chose avec le commentaire (envoyez-le au serveur, mettez à jour l'interface utilisateur, etc.)

    // Fermez la boîte de dialogue après avoir ajouté le commentaire (ajustez selon vos besoins)
    this.close(event);
  }
}
