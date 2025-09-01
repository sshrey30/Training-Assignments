import java.util.Arrays;

public class Association {
    public static void main(String[] args) {
        Oven1 oven = new Oven1();

        Ingredient[] ingredients = {
                new Ingredient("Flour", 500),
                new Ingredient("Butter", 100),
                new Ingredient("Sugar", 200),
                new Ingredient("Cocoa Powder", 100)
        };

        CakeDefinition def = new CakeDefinition("Chocolate", "Square", 1, "Cream");
        Electricity e = new Electricity("Reliance", 8);

        Cake1 cake = oven.bakeCake(def, ingredients, e);
        Cake1 cake1 = oven.bakeCake(def, ingredients);

        cake.cakeInfo();
        cake1.cakeInfo();
    }
}

class Food1 {}

class Cake1 extends Food1 {
    CakeDefinition def;
    double price;

    public Cake1(CakeDefinition def, double price) {
        this.def = def;
        this.price = price;
    }

    void cakeInfo() {
        System.out.println("Cake Ready: " + def);
        System.out.println("Cake Bill : " + price + " Rs.");
    }
}

class CakeDefinition {
    String flavour;
    String shape;
    double weight;
    String decoration;

    public CakeDefinition(String flavour, String shape, double weight, String decoration) {
        this.flavour = flavour;
        this.shape = shape;
        this.weight = weight;
        this.decoration = decoration;
    }

    @Override
    public String toString() {
        return flavour + " Cake | Shape: " + shape + " | Weight: " + weight + "kg | Decoration: " + decoration;
    }
}

class Ingredient {
    String name;
    double qty;

    public Ingredient(String name, double qty) {
        this.name = name;
        this.qty = qty;
    }

    @Override
    public String toString() {
        return name + " (" + qty + ")";
    }
}

class Oven1 {
    Oven1() {
        System.out.println("Lets start preparation...");
    }
    Cake1 bakeCake(CakeDefinition def, Ingredient[] ingredients, Electricity e) {
        System.out.println("Preparing batter using " + Arrays.toString(ingredients));
        System.out.println("Baking " + def.flavour + " cake in oven...");
        System.out.println("Using electricity: " + e.provider + " at cost " + e.costPerUnit + " Rs/unit...");

        double bill = (ingredients.length * e.costPerUnit) + (def.weight * 500);
        return new Cake1(def, bill);
    }
    Cake1 bakeCake(CakeDefinition def, Ingredient[] ingredients) {
        System.out.println("Preparing batter using " + Arrays.toString(ingredients));
        System.out.println("Baking " + def.flavour + " cake in oven...");

        double bill = Math.round(def.weight * 1000 / 1.5);
        return new Cake1(def, bill);
    }
}

class Electricity {
    String provider;
    int costPerUnit;

    Electricity(String p, int c) {
        provider = p;
        costPerUnit = c;
    }
}
