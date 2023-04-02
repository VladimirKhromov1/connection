import {writable} from 'svelte/store';

export type Account = {
    email: string | '';
    username: string | '';
    firstName: string | '';
    lastName: string | '';
}