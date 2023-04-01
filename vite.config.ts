import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import sveltePreprocess from 'svelte-preprocess';
import {viteCommonjs} from '@originjs/vite-plugin-commonjs';
import { svelte } from "@sveltejs/vite-plugin-svelte";
import {resolve} from "path";

export default defineConfig({
  resolve: {
    alias: {
      Store: resolve(__dirname, './app/frontend/store'),
      Components: resolve(__dirname, './app/frontend/components'),
      Utility: resolve(__dirname, './app/frontend/utility'),
      Ui: resolve(__dirname, './app/frontend/components/ui'),
      Types: resolve(__dirname, './app/frontend/types'),
    },
  },
  plugins: [
    viteCommonjs(),
    RubyPlugin(),
    svelte({
      preprocess: sveltePreprocess({
        postcss: true,
      }),
    }),
  ],
})
