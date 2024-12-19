import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import path from 'path';
import dotenv from 'dotenv';

// Load .env from root directory
dotenv.config({
  path: path.resolve(__dirname, '.env')
});

export default defineConfig({
  plugins: [react()],
  define: {
    'import.meta.env.SERVER': JSON.stringify(process.env.SERVER)
  }
});