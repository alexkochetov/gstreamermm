/*
 * test-bin.cc
 *
 *  Created on: Jul 31, 2013
 *      Author: m.kolny
 */

#include <gtest/gtest.h>
#include <gstreamermm.h>
#include <string>

using namespace Gst;
using Glib::RefPtr;

class BinTest : public ::testing::Test
{
protected:
  RefPtr<Bin> bin;
  static std::string element_name;
  static std::string default_element;

  virtual void SetUp()
  {
    bin = Bin::create("sample-bin");
  }

  RefPtr<Element> AddElementToBin(const std::string& element_name = default_element, const std::string& name = element_name)
  {
    RefPtr<Element> element = ElementFactory::create_element(element_name, name);
    bin->add(element);
    return element;
  }
};

std::string BinTest::default_element = "fakesrc";
std::string BinTest::element_name = "source";

TEST_F(BinTest, ShouldCreateBinWithGivenName)
{
  ASSERT_TRUE(bin);
}

TEST_F(BinTest, ShouldCreateBinWithAutogeneratedName)
{
  RefPtr<Bin> test_bin = Bin::create();

  ASSERT_TRUE(test_bin);
}

TEST_F(BinTest, ShouldThrowExceptionOnNullElementAdded)
{
  RefPtr<Element> empty;

  ASSERT_THROW(bin->add(empty), std::runtime_error);
}

TEST_F(BinTest, ShouldFindElementInBin)
{
  AddElementToBin();
  RefPtr<Element> source_copy = bin->get_element(element_name);

  ASSERT_TRUE(source_copy);
}

TEST_F(BinTest, ShouldntFindNonexistingElementInBin)
{
  AddElementToBin();
  RefPtr<Element> source_copy = bin->get_element("element-with-this-name-cannot-exists-in-bin");

  ASSERT_FALSE(source_copy);
}

TEST_F(BinTest, ShouldRemoveElementFromBin)
{
  AddElementToBin();
  RefPtr<Element> source = bin->get_element(element_name);
  bin->remove(source);
  RefPtr<Element> source_copy = bin->get_element(element_name);

  ASSERT_FALSE(source_copy);
}

TEST_F(BinTest, ShouldFindElementRecursive)
{
  RefPtr<Bin> bin_child = Bin::create();
  AddElementToBin();
  bin->add(bin_child);
  RefPtr<Element> source = bin_child->get_element_recurse_up(element_name);

  ASSERT_TRUE(source);
}

TEST_F(BinTest, AddTwoElementsWithTheSameName)
{
  AddElementToBin();

  EXPECT_THROW(AddElementToBin(), std::runtime_error);
}

TEST_F(BinTest, ShouldFindUnlinkedPads)
{
  AddElementToBin();
  AddElementToBin("fakesink", "sink");

  RefPtr<Pad> pad_sink = bin->find_unlinked_pad(PAD_SINK);
  RefPtr<Pad> pad_src = bin->find_unlinked_pad(PAD_SRC);

  ASSERT_TRUE(pad_sink);
  ASSERT_TRUE(pad_src);
}

TEST_F(BinTest, ShouldNotFindUnlinkedPads)
{
    RefPtr<Element> src = AddElementToBin();
    RefPtr<Element> sink = AddElementToBin("fakesink", "sink");

    src->link(sink);

    RefPtr<Pad> pad_sink = bin->find_unlinked_pad(PAD_SINK);
    RefPtr<Pad> pad_src = bin->find_unlinked_pad(PAD_SRC);

    ASSERT_FALSE(pad_sink);
    ASSERT_FALSE(pad_src);
}

TEST_F(BinTest, ShouldReturnCorrectQuantityOfChildren)
{
  int element_count = 5;

  for (int i =0; i < element_count; i++)
    AddElementToBin("fakesrc", std::string(std::string("element") + std::to_string(i)).c_str());

  EXPECT_EQ(element_count, bin->get_num_children());
}

TEST_F(BinTest, ShouldCorrectIterateElements)
{
  AddElementToBin("fakesrc", "element1");
  AddElementToBin("fakesrc", "element2");
  std::vector<std::string> elements = {"element1", "element2"};

  Gst::Iterator<Gst::Element> iterator = bin->iterate_elements();

  while (iterator.next())
  {
    auto pos = std::find(elements.begin(), elements.end(), iterator->get_name());
    ASSERT_NE(elements.end(), pos);
    elements.erase(pos);
  }

  ASSERT_EQ(0u, elements.size());
}

TEST_F(BinTest, ShouldContainsAddedElements)
{
  AddElementToBin("fakesrc", "fakesrc0");
  AddElementToBin("tee", "tee0");
  AddElementToBin("queue", "queue0");
  std::vector<std::string> elements = {"fakesrc0", "tee0", "queue0"};

  Glib::ListHandle<RefPtr<Element> > children = bin->get_children();
  for (auto element : children)
  {
    auto pos = std::find(elements.begin(), elements.end(), element->get_name());
    ASSERT_NE(elements.end(), pos);
    elements.erase(pos);
  }
  ASSERT_EQ(0u, elements.size());
}

TEST_F(BinTest, ShouldCallOnElementAddedHandler)
{
  bool call = false;
  bin->signal_element_added().connect([&call](const RefPtr<Element>&){
    call = true;
  });
  AddElementToBin();
  ASSERT_TRUE(call);
}

TEST_F(BinTest, ShouldCallOnElementRemovedHandler)
{
  bool call = false;
  RefPtr<Element> e = AddElementToBin();
  bin->signal_element_removed().connect([&call](const RefPtr<Element>&){
    call = true;
  });
  bin->remove(e);

  ASSERT_TRUE(call);
}

class OverrideBin : public Bin
{
  bool add_element_flag = false;
  bool remove_element_flag = false;
public:
  OverrideBin() : Bin() {}
  bool add_element_vfunc(const Glib::RefPtr<Gst::Element>& element) override
  {
    add_element_flag = true;
    return Bin::add_element_vfunc(element);
  }
  bool remove_element_vfunc(const Glib::RefPtr<Gst::Element>& element) override
  {
    remove_element_flag = true;
    return Bin::remove_element_vfunc(element);
  }

  bool get_add_flag() const { return add_element_flag; }
  bool get_remove_flag() const { return remove_element_flag; }
};

TEST_F(BinTest, ShouldCorrectOverrideAddAndRemoveElementFunction)
{
  OverrideBin bin;
  RefPtr<Element> element = ElementFactory::create_element("tee");
  bin.add(element);
  ASSERT_TRUE(bin.get_add_flag());
  bin.remove(element);
  ASSERT_TRUE(bin.get_remove_flag());
}
