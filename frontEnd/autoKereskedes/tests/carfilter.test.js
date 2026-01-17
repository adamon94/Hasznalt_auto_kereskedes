import Cars from '../src/pages/cars.vue';
import { mount, flushPromises } from '@vue/test-utils';
import { expect, describe, it, beforeEach, vi } from 'vitest';

global.fetch = vi.fn();

const mockCars = [
  {
    id: 1,
    marka: 'Suzuki',
    model: 'Swift',
    ar: 5000000,
    gyartasEve: 2020,
    uzemAnyagTipus: 'Benzin',
    sebessegValtoRendszer: 'Manuális',
    ferohely: 5,
    hengerUrTartalom: 1200,
    Images: [{ path: 'suzuki.jpg' }]
  },
  {
    id: 2,
    marka: 'BMW',
    model: 'X5',
    ar: 15000000,
    gyartasEve: 2022,
    uzemAnyagTipus: 'Dízel',
    sebessegValtoRendszer: 'Automata',
    ferohely: 7,
    hengerUrTartalom: 3000,
    Images: [{ path: 'bmw.jpg' }]
  },
  {
    id: 3,
    marka: 'Toyota',
    model: 'Corolla',
    ar: 8000000,
    gyartasEve: 2019,
    uzemAnyagTipus: 'Hybrid',
    sebessegValtoRendszer: 'Automata',
    ferohely: 5,
    hengerUrTartalom: 1800,
    Images: [{ path: 'toyota.jpg' }]
  }
];

describe('Cars Component - Filter Tests', () => {
  beforeEach(() => {
    fetch.mockResolvedValue({
      json: async () => mockCars
    });
  });

  it('should load and display all cars initially', async () => {
    const wrapper = mount(Cars);
    await flushPromises();

    const carCards = wrapper.findAll('.deals__card');
    expect(carCards.length).toBe(3);
  });

  it('should filter cars by brand (Suzuki)', async () => {
    const wrapper = mount(Cars);
    await flushPromises();

    const suzukiButton = wrapper.findAll('.btn').find(btn => 
      btn.text() === 'Suzuki'
    );
    await suzukiButton.trigger('click');
    await wrapper.vm.$nextTick();

    const carCards = wrapper.findAll('.deals__card');
    expect(carCards).toHaveLength(1);
    expect(wrapper.text()).toContain('Swift');
  });

  it('should filter cars by brand (BMW)', async () => {
    const wrapper = mount(Cars);
    await flushPromises();

    const bmwButton = wrapper.findAll('.btn').find(btn => 
      btn.text() === 'BMW'
    );
    await bmwButton.trigger('click');
    await wrapper.vm.$nextTick();

    const carCards = wrapper.findAll('.deals__card');
    expect(carCards).toHaveLength(1);
    expect(wrapper.text()).toContain('X5');
  });

  it('should filter cars by price range', async () => {
  const wrapper = mount(Cars);
  await flushPromises();

  wrapper.vm.priceRange = [6000000, 20000000];
  await wrapper.vm.$nextTick();
  await wrapper.vm.$nextTick(); 

  const carCards = wrapper.findAll('.deals__card');
  console.log('Filtered cars:', carCards.length); 
  console.log('Price range:', wrapper.vm.priceRange); 
  expect(carCards).toHaveLength(2); 
  expect(wrapper.text()).not.toContain('Swift');
});

it('should filter cars by year range', async () => {
  const wrapper = mount(Cars);
  await flushPromises();

  
  wrapper.vm.yearRange = [2020, 2024];
  await wrapper.vm.$nextTick();
  await wrapper.vm.$nextTick(); 

  const carCards = wrapper.findAll('.deals__card');
  console.log('Filtered cars:', carCards.length); 
  console.log('Year range:', wrapper.vm.yearRange); 
  expect(carCards).toHaveLength(2); 
});

  it('should filter cars by fuel type (Dízel)', async () => {
    const wrapper = mount(Cars);
    await flushPromises();

    wrapper.vm.fuelType = 'Dízel';
    await wrapper.vm.$nextTick();

    const carCards = wrapper.findAll('.deals__card');
    expect(carCards).toHaveLength(1);
    expect(wrapper.text()).toContain('X5');
  });
});