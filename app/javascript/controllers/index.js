console.log("✅ controllers/index.js loaded");

import { application } from "../application";
console.log("✅ application imported");

import HelloController from "./hello_controller";
application.register("hello", HelloController);

console.log("✅ HelloController registered");
