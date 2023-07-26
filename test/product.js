const Product = artifacts.require('./Product.sol')

contract('Product', (accounts) => {
  let product = null;
  before(async () => {
    product = await Product.deployed();
  });

  it('Should create a new item', async () => {
    await product.createItem('Item1', 'Description', 100, {from: accounts[0]});
    const item = await product.items(0);
    assert(item.id.toNumber() === 0);
    assert(item.name === 'Item1');
    assert(item.description === 'Description');
    assert(item.price.toNumber() === 100);
  });

  it('Should buy an item', async () => {
    await product.buyItem(0, {from: accounts[1], value: 100});
    const item = await product.items(0);
    assert(item.owner === accounts[1]);
    assert(item.purchased === true);
  });
});
