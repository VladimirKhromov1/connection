export default class SvelteRailsUJS {
  static start() {
    SvelteRailsUJS.mountComponents()

    document.addEventListener('DOMContentLoaded',
      SvelteRailsUJS.mountComponents)

    document.addEventListener('turbolinks:load',
      SvelteRailsUJS.mountComponents)
  }

  static mountComponents() {
    document.querySelectorAll('[data-svelte-class]:not([data-svelte-initialized])')
      .forEach(SvelteRailsUJS.mountComponent)
  }

  // This function is pretty hacky looking, but it's the only way to ensure that the glob patterns explicitly handle nested routes
  // the dynamic import plugin resolves ${name} to /* so all the sub folders are squashed otherwise
  // NOTE: if we ever need to nest a component deeper than 10 levels, we'll need to add more cases
  static importComponent(name) {
    const fp = name.split('/')
    switch (fp.length) {
      case 1:
        return import(`../../components/${name}.svelte`)
      case 2:
        return import(`../../components/${fp[0]}/${fp[1]}.svelte`)
      case 3:
        return import(`../../components/${fp[0]}/${fp[1]}/${fp[2]}.svelte`)
      case 4:
        return import(`../../components/${fp[0]}/${fp[1]}/${fp[2]}/${fp[3]}.svelte`)
      case 5:
        return import(`../../components/${fp[0]}/${fp[1]}/${fp[2]}/${fp[3]}/${fp[4]}.svelte`)
      case 6:
        return import(`../../components/${fp[0]}/${fp[1]}/${fp[2]}/${fp[3]}/${fp[4]}/${fp[5]}.svelte`)
      case 7:
        return import(`../../components/${fp[0]}/${fp[1]}/${fp[2]}/${fp[3]}/${fp[4]}/${fp[5]}/${fp[6]}.svelte`)
      case 8:
        return import(`../../components/${fp[0]}/${fp[1]}/${fp[2]}/${fp[3]}/${fp[4]}/${fp[5]}/${fp[6]}/${fp[7]}.svelte`)
      case 9:
        return import(`../../components/${fp[0]}/${fp[1]}/${fp[2]}/${fp[3]}/${fp[4]}/${fp[5]}/${fp[6]}/${fp[7]}/${fp[8]}.svelte`)
      case 10:
        return import(`../../components/${fp[0]}/${fp[1]}/${fp[2]}/${fp[3]}/${fp[4]}/${fp[5]}/${fp[6]}/${fp[7]}/${fp[8]}/${fp[9]}.svelte`)
      default:
        return import(`../../components/${name}.svelte`)
    }
  }

  static async mountComponent(target) {
    if (target.dataset.svelteInitialized) {
      return console.log(`${target} is already mounted.`)
    }
    target.dataset.svelteInitialized = true

    const name = target.dataset.svelteClass
    const hydrate = !!target.dataset.hydrate

    let props = {}

    if (target.dataset.svelteProps) {
      props = JSON.parse(target.dataset.svelteProps)
    }

    const { default: Component } = await SvelteRailsUJS.importComponent(name)
    new Component({target, props, hydrate})
  }
}
