import { Application } from "@hotwired/stimulus";
import "@hotwired/turbo-rails";
import "./controllers/index.js";

console.log("✅ application.js loaded");

const application = Application.start();
window.Stimulus = application;

export { application };
