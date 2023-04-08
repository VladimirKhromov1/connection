import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'
import sveltePreprocess from 'svelte-preprocess';
import image from 'svelte-image';
import {viteCommonjs} from '@originjs/vite-plugin-commonjs';
import { svelte } from "@sveltejs/vite-plugin-svelte";

export default defineConfig({
  plugins: [
    viteCommonjs(),
    RubyPlugin(),
    svelte({
      preprocess: sveltePreprocess({
        ...image(),
      }),
    }),
  ],
})
