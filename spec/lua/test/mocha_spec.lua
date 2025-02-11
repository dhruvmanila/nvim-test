local helpers = require "spec.lua.helpers"

describe("mocha", function()
  before_each(function()
    helpers.before_each { run = false, runners = { javascript = "nvim-test.runners.mocha" } }
  end)
  after_each(helpers.after_each)

  local filename = vim.fn.fnamemodify("spec/lua/test/fixtures/test.js", ":p")

  it("run suite", function()
    helpers.view(filename)
    vim.api.nvim_command "TestSuite"
    assert.are.equal(vim.g.test_latest.cmd, "mocha")
  end)

  it("run file", function()
    helpers.view(filename)
    vim.api.nvim_command "TestFile"
    assert.are.equal(vim.g.test_latest.cmd, "mocha " .. filename)
  end)

  it("run nearest function", function()
    helpers.view(filename, 4)
    vim.api.nvim_command "TestNearest"
    assert.are.equal(vim.g.test_latest.cmd, "mocha " .. filename .. " -f 'jstest ns test1'")
  end)

  it("run latest", function()
    helpers.view(filename)
    vim.api.nvim_command "TestFile"
    assert.are.equal(vim.g.test_latest.cmd, "mocha " .. filename)

    vim.api.nvim_command "TestLast"
    assert.are.equal(vim.g.test_latest.cmd, "mocha " .. filename)
  end)
end)
