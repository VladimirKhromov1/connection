import {writable} from 'svelte/store';

export type Account = {
    id: string | '';
    email: string | '';
    username: string | '';
    firstName: string | '';
    lastName: string | '';
    photo: string | '';
    age: string | '';
    country: string | '';
    city: string | '';
}