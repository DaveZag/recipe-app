import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };

// temporary solution to turbo links event listener disappearance when changing views without reloading
import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = false;
